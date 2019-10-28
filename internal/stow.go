package internal

import (
	"errors"
	"fmt"
	"io/ioutil"
	"os"

	"github.com/fatih/color"
)

type stowLink struct {
	Source string
	Target string
}

func getLinks() []stowLink {
	home, _ := os.UserHomeDir()
	links := []stowLink{
		stowLink{Source: "git", Target: home},
		stowLink{Source: "shell", Target: home},
		stowLink{Source: "vim", Target: home},
	}
	return links
}

// checkContext makes sure we're stowing the right files
func checkContext() error {
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

// stow source to target
func stow(link stowLink) error {
	formatter := color.New(color.FgGreen)
	formatter.Printf("Linking %s to %s \n", link.Source, link.Target)

	command := fmt.Sprintf("stow -t %s %s", link.Target, link.Source)
	c := GetCommand(command)
	c.Dir = "stow"
	err := c.Run()

	if err != nil {
		return err
	}

	return nil
}

// unstow source from target
func unstow(link stowLink) error {
	formatter := color.New(color.FgRed)
	formatter.Printf("Unlinking %s from %s \n", link.Source, link.Target)

	command := fmt.Sprintf("stow -t %s -D %s", link.Target, link.Source)
	c := GetCommand(command)
	c.Dir = "stow"
	err := c.Run()
	if err != nil {
		return err
	}

	return nil
}

// StowAll sources to targets
func StowAll() error {
	checkContext()

	links := getLinks()
	for _, link := range links {
		err := stow(link)
		if err != nil {
			return err
		}
	}

	return nil
}

// UnstowAll sources from targets
func UnstowAll() error {
	checkContext()

	links := getLinks()
	for _, link := range links {
		err := unstow(link)
		if err != nil {
			return err
		}
	}

	return nil
}
