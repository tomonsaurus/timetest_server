<?php

$day1 = new DateTime('2017-08-1 10:00:00');
$day2 = new DateTime('2017-08-1 13:00:00');

$now = new DateTime();


if($now > $day1 && $now < $day2) {

        print "HELLO!!!<br>OPEN";

        exit;

}

print "close...";




?>