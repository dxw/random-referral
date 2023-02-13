# Random Referral

This is a web service to allow people to find referral codes from other people
at dxw.

https://dxw-random-referral.herokuapp.com/

## Why?

We have a spreadsheet that stores referral codes for various products and
services that dxw folks have purchased.

[Spreadsheet](https://docs.google.com/spreadsheets/d/1fAIEUS1w8wiTfyzrdODdFknuAZdPTrmgc5imZ0ZvNtk/edit?usp=sharing)

This was set up to help folks make greener choices. It was then decided that it
would help make it fairer for all those who added codes if the access was
randomised. So we made this!

## How to run it locally

```
bundle exec rails server
```

You will need to set some environment variables to tell the service how to
authenticate with Google Drive. 1Password has a `.env` file you can use
(under Random referral within the Rails 1password vault), or you can create
your own service account and share the spreadsheet with it.
