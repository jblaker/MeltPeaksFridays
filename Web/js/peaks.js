function PeaksCtrl($scope) {

	$scope.employees = [];
	$scope.peopleGoingText;

	Parse.initialize("5tRAN4Vrq3yzWKoRnbJ1sczY2beR1l0GEALMHcUP", "WFcsBEsCFfWIBFRtoxiRtr7id4GscdqqVUEXC3m3");

	var query = new Parse.Query(Parse.User);
	query.find({
	  success: function(employees) {
	  	$scope.$apply($scope.employees = employees);
	  	countPeopleGoing();
	  }
	});

	function countPeopleGoing() {
		var goingCount = 0;

		$scope.employees.forEach(function(employee){
			if (employee.get('isGoing')) {
				goingCount++;
			}
		});

		if(goingCount == 1) {
			$scope.$apply(function(){
				$scope.peopleGoingText = "is " + goingCount.toString() + " person";
			});
		} else {
			$scope.$apply(function(){
				$scope.peopleGoingText = "are " + goingCount.toString() + " people";
			});
		}
		
	}

}