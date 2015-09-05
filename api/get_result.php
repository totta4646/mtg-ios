<?php

require_once( 'config.php' );

try {
    $pdo = new PDO('mysql:host=' . $host . ';dbname=' . $db . ';charset=utf8' , $user , $pass,
    array(PDO::ATTR_EMULATE_PREPARES => false));

    $parameter = $_GET['user'];

    // 保存
    $user_table = "USER";
    $result_table = "RESULT";
    $res = array();
    $stasus = 200;

    $stmt = $pdo-> prepare("SELECT COUNT( * ) as row_cnt FROM $user_table");
    $success = $stmt->execute();
    if ($success) {
        $data = $stmt->fetch(PDO::FETCH_ASSOC);
        $user_sum = $data["row_cnt"];

        for ($i = 1; $i <= $user_sum; $i++) {
            $stmt = $pdo-> prepare("SELECT *,count( * ) as win_cnt FROM $result_table RIGHT JOIN $user_table ON $result_table.LOSER = $user_table.ID where WINNER=$parameter AND LOSER=$i");
            $stmt->execute();
            $data = $stmt->fetch(PDO::FETCH_ASSOC);
            $success = $stmt->execute();
            $result = [
                'win_sum'=> $data["win_cnt"],
                'rival_id'=> $i,
                'rival_name'=>$data["NAME"]
                ];
            array_push( $res, $result );

        }
    } else {
        $stasus = 400;
        $error = "DB参照エラー: USER TABLE";
        $res =  array('status'=> $stasus,'error'=> $error);
    }

    echo json_encode( $res );

} catch (PDOException $e) {
    exit('データベース接続失敗。'.$e->getMessage());
}
?>