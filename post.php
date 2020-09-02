<?php foreach($_POST['scn'] as $item)
{
  echo $item."<br>";
}
?>
<form method="POST" action="<?php $_SERVER["PHP_SELF"] ?>">
<input type="text" name="scn[]">
<input type ="text" name="scn[]">
<input type="submit">
</form>