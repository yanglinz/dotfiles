package cmd

import (
	"github.com/spf13/cobra"
	"github.com/yanglinz/dotfiles/internal"
)

var linkCmd = &cobra.Command{
	Use:   "link",
	Short: "Link stow",
	Long:  "Link stow",
	Run: func(cmd *cobra.Command, args []string) {

		err := internal.EnsureCWD()
		if err != nil {
			panic(err)
		}
	},
}

func init() {
	rootCmd.AddCommand(linkCmd)
}
