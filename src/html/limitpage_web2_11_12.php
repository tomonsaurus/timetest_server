<?php

$day1 = new DateTime('2017-08-1 11:00:00');
$day2 = new DateTime('2017-08-1 12:00:00');

$now = new DateTime();


if($now > $day1 && $now < $day2) {

        print "HELLO web2!!!<br> OPEN";

        exit;

}

print "close web2...";




?>
