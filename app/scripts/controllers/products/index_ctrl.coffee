class IndexCtrl

  @$inject = ["$scope", "alerts", "products"]
  constructor: (@$scope, @alerts, @products) ->
    $scope.products = products

    $scope.gridColumnDefs = [
      { field: "id", displayName: "#", width: "auto" }
      { field: "name", displayName: "Name", resizable: true }
      { field: "price", displayName: "Price", width: "120px", resizable: false }
      { field: "description", displayName: "Description" }
      { field: "createdAt", displayName: "Created At" }
    ]

    $scope.gridOptions =
      data: "products"
      columnDefs: "gridColumnDefs"
      enableColumnResize: true

  deleteProduct: (product) ->
    promise = product.$delete()
    promise.then =>
      index = @products.indexOf(product)
      @products.splice(index, 1) if index isnt -1

      @alerts.info "Product was deleted"

angular.module("myApp")
  .controller("products.IndexCtrl", IndexCtrl)
