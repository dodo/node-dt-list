
add = function (x) {
	console.log(this, this.e)
	return this.e + x
}

function Test() {
	this.e = 3
};

Test.prototype.add = function (x) {
	return this.e = add(x)
}



test = new Test
console.log(test.add(4))

