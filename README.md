# Random Referral

We currently have a spreadsheet which stores referral codes for various different products and services that dxw folks have purchased.

[Spreadsheet](https://docs.google.com/spreadsheets/d/1fAIEUS1w8wiTfyzrdODdFknuAZdPTrmgc5imZ0ZvNtk/edit?usp=sharing)

This was set up to help folks make greener choices.
It was then decided that it would help make it fairer for all those who added codes, that the access was randomised.
So we made this!

This is a web service to allow people to find referral codes from other people at dxw.

## Run it

```
bundle exec ruby server.rb
```

You will need a file `.data/gsuite-auth-config.json`.
This is a config file for a Goolge Server Account.
This can be found in 1password under `Google Service Account Config for Random Referrals`.