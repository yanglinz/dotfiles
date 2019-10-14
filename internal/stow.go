package internal

import (
	"errors"
	"fmt"
	"io/ioutil"
	"os"

	"github.com/fatih/color"
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

// Stow files
func Stow(source string, target string) error {
	c := color.New(color.FgGreen)
	c.Printf("Linking %s to %s \n", source, target)
	command := fmt.Sprintf("stow -t %s %s", target, source)
	err := RunCommand(command)
	if err != nil {
		return err
	}

	return nil
}

// Unstow files
func Unstow(source string, target string) error {
	c := color.New(color.FgRed)
	c.Printf("Unlinking %s from %s \n", source, target)
	command := fmt.Sprintf("stow -t %s -D %s", target, source)
	err := RunCommand(command)
	if err != nil {
		return err
	}

	return nil
}
