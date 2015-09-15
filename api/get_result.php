<?php

require_once( 'config.php' );

try {
    $pdo = new PDO('mysql:host=' . $host . ';dbname=' . $db . ';charset=utf8' , $user , $pass,
    array(PDO::ATTR_EMULATE_PREPARES => false));

    $user_param = $_GET['user'];
    $rival_param = $_GET['rival'];

    // 保存
    $user_table = "USER";
    $result_table = "RESULT";
    $res = array();
    $stasus = 200;

    $stmt = $pdo-> prepare("SELECT * FROM $user_table");
    $success = $stmt->execute();
    $user_list = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $stmt = $pdo-> prepare("SELECT *, count(*) as cnt
    FROM RESULT
    where WINNER=$user_param AND LOSER=$rival_param
    ");


            $stmt->execute();
            $win_data = $stmt->fetch(PDO::FETCH_ASSOC);

    $stmt = $pdo-> prepare("SELECT *, count(*) as cnt
    FROM RESULT
    where WINNER=$rival_param AND LOSER=$user_param
    ");

            $stmt->execute();
            $lose_data = $stmt->fetch(PDO::FETCH_ASSOC);

            // var_dump($data);
            // exit();
            $result = [
                'user_id'=> $user_param,
                'rival_id'=> $rival_param,
                'win_sum'=> $win_data["cnt"],
                'lose_sum'=> $lose_data["cnt"],
                'my_name'=>$user_list[$user_param]["NAME"],
                'rival_name'=>$user_list[$rival_param]["NAME"]
                ];
            $stasus = 200;
            $data = $sql;
            $res =  array('status'=>$stasus, 'data'=>$result);
            header('Content-type: application/json');
            // array_push( $res, $result );

    //     }
    // } else {
    //     $stasus = 400;
    //     $error = "DB参照エラー: USER TABLE";
    //     $res =  array('status'=> $stasus,'error'=> $error);
    // }

    echo json_encode( $res );

} catch (PDOException $e) {
    exit('データベース接続失敗。'.$e->getMessage());
}
?>