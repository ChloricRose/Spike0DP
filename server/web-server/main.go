package main

import (
	"net/http"
	"github.com/gin-gonic/gin"
)

//info represents data about an object

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

func main(){
	router := gin.Default()
	router.GET("/objects", getObjects)
	router.GET("/objects/:id", getObjectByID)
	router.POST("/objects", postObject)
	router.Run("localhost:8080")
}
