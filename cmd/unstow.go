package cmd

import (
	"github.com/spf13/cobra"
	"github.com/yanglinz/dotfiles/internal"
)

var unstowCmd = &cobra.Command{
	Use:   "unstow",
	Short: "Remove stow symlinks",
	Long:  "Remove stow symlinks",
	Run: func(cmd *cobra.Command, args []string) {

		err := internal.UnstowAll()
		if err != nil {
			panic(err)
		}
	},
}

func init() {
	rootCmd.AddCommand(unstowCmd)
}
