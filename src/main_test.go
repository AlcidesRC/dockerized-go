package main

import "testing"

func TestHello(t *testing.T) {
	t.Run("say 'Hello, John Doe'", func(t *testing.T) {
		got := Hello("John Doe")
		want := "Hello, John Doe"
		assertCorrectMessage(t, got, want)
	})

	t.Run("say 'Hello, world!' when an empty string is supplied", func(t *testing.T) {
		got := Hello("")
		want := "Hello, world!"
		assertCorrectMessage(t, got, want)
	})
}

func assertCorrectMessage(t testing.TB, got, want string) {
	t.Helper()
	if got != want {
		t.Errorf("got %q want %q", got, want)
	}
}
