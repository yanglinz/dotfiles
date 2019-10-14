package internal

import (
	"os"
	"os/exec"
	"strings"
)

// RunCommand runs a shell command in cwd
func RunCommand(command string) error {
	commandList := strings.Split(command, " ")
	first := commandList[0]
	rest := commandList[1:]

	c := exec.Command(first, rest...)
	c.Dir = "."
	c.Stdout = os.Stdout
	c.Stdin = os.Stdin
	c.Stderr = os.Stderr

	err := c.Run()
	if err != nil {
		return err
	}

	return nil
}
