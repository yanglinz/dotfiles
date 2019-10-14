package cmd

import (
	"github.com/spf13/cobra"
)

var rootFlag string

var rootCmd = &cobra.Command{
	Use:   "dot",
	Short: "My personal dotfiles",
	Long:  "My personal dotfiles",
	Run: func(cmd *cobra.Command, args []string) {
		cmd.Help()
	},
}

// Execute is the main entrypoint for cobra
func Execute() {
	if err := rootCmd.Execute(); err != nil {
		panic(err)
	}
}
