# timetest

## サーバー時間変更テストフレームワーク　[プロトタイプ]

### 概要
 * 現段階ではプロトタイプ。
   * かなり適当な実装。

 * サーバーの時間ごとの振る舞いをテストする
   * 例
     * cron設定されているプログラム
     * atコマンドで設定されているプログラム
     * 一定時間のWEBページの表示変更

### 実行方法

```
git clone https://github.com/tomonsaurus/timetest_server.git
cd timetest_server
vagrant up
```

192.168.33.110にsshログインして次を実行
```
cd ~
git clone https://github.com/tomonsaurus/timetest_src.git
```

 * vagrantで起動されるサーバー
    * 192.168.33.110 : テスト対象サーバー（192.168.33.20）に対してテストを実行するサーバー centos7,ruby,ansible
    * 192.168.33.20  : テスト対象サーバー centos6, apache,php

 * 192.168.33.20  : テスト対象サーバー
    * cron
      * vagrantユーザーに１時間毎、１分ごと、一定時間に実行されるプログラムがしかけてある。
      * ~/src/batch/cronexec.log　にログ出力するだけのプログラム
    * http://192.168.33.20/limitpage.php
      * '2017-08-1 10:00:00' - '2017-08-1 13:00:00' この間は「HELLO!!!<br>OPEN」と表示。その他の時間は「close...」


   * 192.168.33.110にSSHログイン。

   * 192.168.33.110から192.168.33.20にSSHログイン
     これは最初に1回だけやればよいです。やらないとansible実行時にknown_hostsにないと言われておこられるためにやります。 
```
ssh 192.168.33.20

```
   * 192.168.33.110にもどり、以下を実行。

```
cd ~/timetest_src/timetest/
ruby timetest.rb

```

### テスト実行内容

   * ~/timetest_src/timetest/conf/config, hostsをみながら実行
   * テスト対象サーバー（192.168.33.20）の時間設定を"2017/8/1 11:00:00" - "2017/8/1 15:00:00"まで、１時間毎に変更する。
　    * もう少し細かい設定もあり。
     * wgetでhttp://192.168.33.20/limitpage.phpを取得して ~/timetest_src/timetest/result以下に格納。
   * 実行結果の確認
     * cronやWEBページが設定どおりの振る舞いをしているか確認。
       * WEBページ: ~/timetest_src/timetest/resultの下のファイルを確認
       * cron:  ~/src/batch/cronexec.logに出力されている内容を確認。

### トラブルシューティング
   * 192.168.33.20  : テスト対象サーバーの時間を変更してもすぐに現在時に戻ってしまう。
     * VirtualBox等の場合はホストとの自動時間同期をオフにする
       http://www.virtualbox.org/manual/ch09.html#disabletimesync

       * 実行コマンド

```
cd C:\Program Files\Oracle\VirtualBox
VBoxManage setextradata "[VM NAME]" "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled" 1

```
         * "[VM NAME]"の部分は環境に合わせること。VM名になる。virtualboxを起動させて確認する。
         * C:\Users\[username]\VirtualBox VMs で確認
         * 再起動させないと有効にならない


### TODO
   * テスト方法　rspec, infrataster等を使ってテストらしくしたい。テスト結果、わかりづらい。
