const UbrisToken = artifacts.require("UbrisToken");

module.exports = function(deployer) {
    deployer.deploy(UbrisToken, 1000);
};