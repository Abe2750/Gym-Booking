<html>
<head>
    <title>CPSC 304 PHP/Oracle Demonstration</title>
</head>
<h2>Projection </h2>
<p>Choose elements you want </p>
<form method="POST" action="newDeli.php">
    <input type="hidden" id="projectQueryRequest" name="projectQueryRequest">
    <label for="projection">Choose</label>
    <select id="firstProject" name="firstProject">
        <option value="ClassName">ClassName</option>
        <option value="GymName">GymName</option>
        <option value="Location">Location</option>
        <option value="trainerName">trainerName</option>
    </select>

    <label for="projection1">From</label>
    <select id="secondProject" name="secondProject">
        <option value="Class1">Class1</option>
        <option value="Gym">Gym</option>
        <option value="PersonalTrainer">PersonalTrainer</option>
    </select>
    <input type="submit" value = "Choose" name="projectSubmit">
</form>

</html>
<body>
</body>
</html>