<?php


// 現在日時取得
$date  = date("Y-m-d H:i:s");

// 現在日時の出力
print "$date\t";


// パラメータ取得

#---- php実行時のパラメータ取得 ----------------------------

//var_dump($argv);


if( count($argv) > 2) {
	print "option error. END:".var_dump($argv)."\n";
	exit;
}

$opt = $argv[1];

print "$opt END\n";









?>