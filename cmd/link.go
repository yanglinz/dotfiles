package cmd

import (
	"github.com/fatih/color"
	"github.com/spf13/cobra"
)

var linkCmd = &cobra.Command{
	Use:   "link",
	Short: "Link stow",
	Long:  "Link stow",
	Run: func(cmd *cobra.Command, args []string) {
		c := color.New(color.FgGreen)
		c.Println("Link!")
	},
}

func init() {
	rootCmd.AddCommand(linkCmd)
}
