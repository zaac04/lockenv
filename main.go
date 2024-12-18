package main

import (
	"embed"
	"os"

	"github.com/zaac04/lockenv/cmd"

	ui "github.com/zaac04/lockenv/Ui"

	"github.com/wailsapp/wails/v2"
	"github.com/wailsapp/wails/v2/pkg/options"
	"github.com/wailsapp/wails/v2/pkg/options/assetserver"
)

//go:embed all:frontend/dist
var assets embed.FS

func main() {
	if len(os.Args) == 1 {
		app := ui.NewApp()
		err := wails.Run(&options.App{
			AssetServer: &assetserver.Options{
				Assets: assets,
			},
			//BackgroundColour: &options.RGBA{R: 27, G: 38, B: 54, A: 1},
			OnStartup: app.Startup,
			Bind: []interface{}{
				app,
			},
		})

		if err != nil {
			println("Error:", err.Error())
		}
	} else {
		cmd.Execute()
	}

}
