package main

import (
	"net/http"
	"github.com/gin-gonic/gin"
	"io/ioutil"
	"os"
	"fmt"
	"log"
	"encoding/json"
)

//info represents data about an object
type weatherinfo struct {
	Name string `json:"name"`
	Main struct{
		Temp float64 `json:"temp"`
	} `json:"main"`
}

//getObject responds with the list of all objects as JSON
func getWeather(c *gin.Context) {
	lon := c.Query("lon")
	lat := c.Query("lat")
	apikey := "9067f8054b718909b3849307f3c05085"
	units := "metric"
	url := "https://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon + "&appid=" + apikey + "&units=" + units

	response, err := http.Get(url)
    	if err != nil {
		fmt.Print(err.Error())
		os.Exit(1)
    	}

	responseData, err := ioutil.ReadAll(response.Body)
	if err != nil {
		log.Fatal(err)
	}

	var responseObject weatherinfo
	json.Unmarshal(responseData, &responseObject)
	c.IndentedJSON(http.StatusOK, responseObject.Main.Temp)
}

func main(){
	router := gin.Default()
	router.GET("/getTemp", getWeather)
	router.Run("172.20.10.2:8080")
}
