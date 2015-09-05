<?php

require_once( 'config.php' );

try {
    $pdo = new PDO('mysql:host=' . $host . ';dbname=' . $db . ';charset=utf8' , $user , $pass,
    array(PDO::ATTR_EMULATE_PREPARES => false));


    // 保存
    $winner_parameter = $_GET['winner'];
    $loser_parameter = $_GET['loser'];

    $table = "RESULT";
    $winner = "WINNER";
    $loser = "LOSER";
    $stmt = $pdo-> prepare("INSERT INTO $table ($winner, $loser) VALUES (:winner, :loser)");
    $stmt->bindValue(':winner', $winner_parameter, PDO::PARAM_INT);
    $stmt->bindValue(':loser', $loser_parameter, PDO::PARAM_INT);

    $success = $stmt->execute();

    if ($success) {
        $stasus = 200;
        $data = array('win'=>$winner_parameter, 'lose'=>$loser_parameter);
        $res =  array('status'=> $stasus, 'data'=>$data);

    } else {
        $stasus = 400;
        $res =  array('status'=> $stasus);
    }

    echo json_encode( $res );

} catch (PDOException $e) {
    exit('データベース接続失敗。'.$e->getMessage());
}
?>