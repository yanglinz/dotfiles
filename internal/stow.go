package internal

import (
	"errors"
	"io/ioutil"
	"os"
)

// EnsureCWD makes sure we're in the correct cwd when stowing files
func EnsureCWD() error {
	dir, err := os.Getwd()
	if err != nil {
		return err
	}

	files, err := ioutil.ReadDir(dir)
	if err != nil {
		return err
	}

	filenames := make(map[string]bool)
	for _, file := range files {
		filenames[file.Name()] = true
	}

	expected := []string{
		"boot",
		"cmd",
		"configs",
		"internal",
		"scripts",
		"stow",
		"main.go",
	}
	for _, f := range expected {
		if !filenames[f] {
			return errors.New("Not in the correct cwd to run stow")
		}
	}

	return nil
}
