class IndexCtrl

  @$inject = ["$scope", "alerts", "Products"]
  constructor: (@$scope, @alerts, @Products) ->
    $scope.totalServerItems = 0

    fetchProducts = (pagingOptions = {}) ->
      options = _.pick(pagingOptions, "currentPage", "pageSize")
      promise = Products.query(options).$promise

      promise.then (data) ->
        $scope.products = data.rows
        $scope.totalServerItems = data.total

    $scope.pagingOptions =
      pageSizes: [2, 3, 5]
      pageSize: 2
      currentPage: 1

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
      totalServerItems: "totalServerItems"
      enableColumnResize: true
      enablePaging: true
      pagingOptions: $scope.pagingOptions
      showFooter: true

    watchPaging = (pagingOptions, oldVal) ->
      return if pagingOptions is oldVal
      fetchProducts(pagingOptions)

    $scope.$watch "pagingOptions", watchPaging, true

    fetchProducts(currentPage: 1, pageSize: 2)

  deleteProduct: (product) ->
    promise = product.$delete()
    promise.then =>
      index = @products.indexOf(product)
      @products.splice(index, 1) if index isnt -1

      @alerts.info "Product was deleted"

angular.module("myApp")
  .controller("products.IndexCtrl", IndexCtrl)
