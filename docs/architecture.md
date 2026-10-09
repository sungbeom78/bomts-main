# Product architecture

BOMTS in this repository is a static public website. It publishes product information,
an English-language entry point, contact details, and legal pages.

```text
Visitor
  -> public web edge
  -> static web service
  -> versioned HTML, CSS, JavaScript, and image assets
```

The website has no application database, login, upload, or server-side contact form.
Browser navigation reads only files shipped with the release. Contact links open the
visitor's mail application rather than storing a submission.

Production edge providers, network addresses, host paths, deployment credentials,
monitoring endpoints, mail infrastructure, and recovery procedures are outside this
repository and belong to the private infrastructure repository.

Other BOMTS products own their own application data and data models. This repository
does not act as their database or system of record.
