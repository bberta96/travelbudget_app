 function multiplyFunction(...args) {
	 //Multiply the arguments
	 var multi = 1;
	 for (var arg of args) {
		multi *= arg;
	 }
	 return multi;
 }
 
 function getValue(p) {
	 return p;
 }

 function sumFunction(...args) {
	 //Sum the arguments
	 var sum = 0;
	 for (var arg of args) {
		sum += arg;
	 }
	 return sum;
 }