package cmd

import (
	"github.com/zaac04/lockenv/crypter"

	"github.com/spf13/cobra"
)

var readCmd = &cobra.Command{
	Use:   "read",
	Short: "reads the encrypted file contents",
	Run: func(cmd *cobra.Command, args []string) {
		filename, _ := cmd.Flags().GetString("file")
		crypter.ReadCipherFile(filename)
	},
}

func init() {
	rootCmd.AddCommand(readCmd)
	readCmd.Flags().StringP("file", "f", "", "filename")
	readCmd.MarkFlagRequired("file")
}
