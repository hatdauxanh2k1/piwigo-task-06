<?php
header('Content-Type: application/json');
define('PHPWG_ROOT_PATH', './');
include_once(PHPWG_ROOT_PATH . 'include/common.inc.php');
echo json_encode($_SESSION['menuApi']);
