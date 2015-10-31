<?php

require_once( 'config.php' );

try {
    $pdo = new PDO('mysql:host=' . $host . ';dbname=' . $db . ';charset=utf8' , $user , $pass,
    array(PDO::ATTR_EMULATE_PREPARES => false));

    $user_param = $_GET['user'];
    $color_param = $_GET['color'];
    $stasus = 400;

    // 保存
    $user_table = "USER";
    $res = array();

    $stmt = $pdo-> prepare("UPDATE USER SET COLOR = $color_param WHERE ID = $user_param");
    $success = $stmt->execute();


    if ($success) {
        $stasus = 200;
    }

    // $user_list = $stmt->fetchAll(PDO::FETCH_ASSOC);


    $data = $sql;
    $res =  array('status'=>$stasus);

    header('Content-type: application/json');

    echo json_encode( $res );

} catch (PDOException $e) {
    exit('データベース接続失敗。'.$e->getMessage());
}
?>