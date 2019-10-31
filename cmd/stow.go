package cmd

import (
	"github.com/spf13/cobra"
	"github.com/yanglinz/dotfiles/internal"
)

var stowCmd = &cobra.Command{
	Use:   "stow",
	Short: "Stow symlinks",
	Long:  "Stow symlinks",
	Run: func(cmd *cobra.Command, args []string) {
		err := internal.StowAll()
		if err != nil {
			panic(err)
		}
	},
}

func init() {
	rootCmd.AddCommand(stowCmd)
}
