package internal

import (
	"os"
	"os/exec"
	"strings"
)

// GetCommand returns a exec cmd
func GetCommand(command string) *exec.Cmd {
	commandList := strings.Split(command, " ")
	first := commandList[0]
	rest := commandList[1:]

	c := exec.Command(first, rest...)
	c.Dir = "."
	c.Stdout = os.Stdout
	c.Stdin = os.Stdin
	c.Stderr = os.Stderr

	return c
}

// RunCommand runs a shell command in cwd
func RunCommand(command string) error {
	c := GetCommand(command)
	err := c.Run()
	if err != nil {
		return err
	}

	return nil
}
