<?php

require_once( 'config.php' );

try {
    $pdo = new PDO('mysql:host=' . $host . ';dbname=' . $db . ';charset=utf8' , $user , $pass,
    array(PDO::ATTR_EMULATE_PREPARES => false));


    // 保存
    $table = "USER";
    $stmt = $pdo-> prepare("SELECT ID as id , NAME as name, COLOR as color FROM $table");
    $success = $stmt->execute();
    if ($success) {
        $sql = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stasus = 200;
        $data = $sql;
        $res =  array('status'=>$stasus, 'data'=>$data);
        header('Content-type: application/json');

    } else {
        $stasus = 400;
        $res =  array('status'=> $stasus);

    }

    echo json_encode( $res );

} catch (PDOException $e) {
    exit('データベース接続失敗。'.$e->getMessage());
}
?>