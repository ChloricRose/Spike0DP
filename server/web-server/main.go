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
	Info []Info `json:"main"`
}

type Info struct {
	Temp float64 `json:"temp"`
}

type object struct {
	ID	string	`json:"id"`
	Title	string	`json:"title"`
	Description	string	`json:"description"`
}

var objects = []object{
	{ID: "1", Title: "Pene", Description: "El pene es un aparato para penetrar"},
	{ID: "2", Title: "Lápiz", Description: "El lápiz es un instrumento para escribir"},
}

//getObject responds with the list of all objects as JSON

func getObjects(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, objects)
}

func getObjectByID(c *gin.Context) {
	id := c.Param("id")
	
	//Loop over objects
	for _, a := range objects {
		if a.ID == id {
			c.IndentedJSON(http.StatusOK, a)
			return
		}
	}
	c.IndentedJSON(http.StatusNotFound, gin.H{"Warning": "Object not found"})
}

func postObject(c *gin.Context) {
	var newObject object

	//call BindJson to bind the recieved json to newobject
	if err := c.BindJSON(&newObject); err != nil {
		return
	}
	//add newobject to objects
	objects = append(objects, newObject)
	c.IndentedJSON(http.StatusCreated, newObject)
}

func getWeather(c *gin.Context) {
	lon := c.Query("lon")
	lat := c.Query("lat")
	apikey := "9067f8054b718909b3849307f3c05085"
	units := "metric"
	url := "https://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon + "&appid=" + apikey + "&units" + units

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

	fmt.Println(responseObject.Name)
	fmt.Println(responseObject.Info)

	c.IndentedJSON(http.StatusOK, responseObject)
}

func main(){
	router := gin.Default()
	router.GET("/objects", getObjects)
	router.GET("/objects/:id", getObjectByID)
	router.GET("/weather", getWeather)
	router.POST("/objects", postObject)
	router.Run("localhost:8080")
}
