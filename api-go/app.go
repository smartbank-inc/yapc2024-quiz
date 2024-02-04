package main

import (
	"net/http"
	"slices"
	"sync"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

var (
	balance   int
	shopNames []string
	mutex     sync.Mutex
)

func main() {
	e := echo.New()
	e.Use(middleware.Logger())

	e.POST("/init", initHandler)
	e.POST("/payments", paymentsHandler)
	e.GET("/summary", summaryHandler)

	e.Logger.Fatal(e.Start(":3000"))
}

func initHandler(c echo.Context) error {
	balance = 100000       // 所持金10万円からスタート！
	shopNames = []string{} // 訪問した店舗名を記録して思い出にする！

	return c.NoContent(http.StatusOK)
}

func paymentsHandler(c echo.Context) error {
	data := struct {
		Amount   int    `json:"amount"`
		ShopName string `json:"shop_name"`
	}{}

	if err := c.Bind(&data); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	mutex.Lock()
	defer mutex.Unlock()

	balance -= data.Amount
	shopNames = append(shopNames, data.ShopName)

	return c.NoContent(http.StatusCreated)
}

func summaryHandler(c echo.Context) error {
	slices.Sort(shopNames)

	response := struct {
		Balance   int      `json:"balance"`
		ShopNames []string `json:"shop_names"`
	}{
		Balance:   balance,
		ShopNames: shopNames,
	}

	return c.JSON(http.StatusOK, response)
}
