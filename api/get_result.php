<?php

require_once( 'config.php' );

try {
    $pdo = new PDO('mysql:host=' . $host . ';dbname=' . $db . ';charset=utf8' , $user , $pass,
    array(PDO::ATTR_EMULATE_PREPARES => false));

    $param = $_GET['user'];

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
            $stmt = $pdo-> prepare("SELECT *,count(*) as cnt
            FROM RESULT LEFT JOIN USER ON RESULT.LOSER = USER.ID
            where WINNER=$param AND LOSER=$i or WINNER=$i AND LOSER=$param
            group by WINNER, LOSER");

            $stmt->execute();
            $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
            // var_dump($data);
            // exit();
            $result = [
                'rival_id'=> $i,
                'win_sum'=> $data[0]["cnt"],
                'lose_sum'=> $data[1]["cnt"],
                'rival_name'=>$data[0]["NAME"]
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