# EVRAK

Flutter (iOS + Android) mobile app for Turkish teachers: personalizes and
generates official MEB-related documents from a teacher/school profile
(template + `{{variable}}` substitution -> PDF), rather than serving static
files. See `docs/catalog/` for the reference document catalog and product
context.

## Workflow

- Development branch: `claude/flutter-mobile-app-tyedze`. Commit and push
  there; don't push to `main`.
- The user has given standing approval for routine work on this branch:
  committing and pushing code changes, running builds/tests, creating
  files. No need to ask before each one.
- Still confirm before anything destructive/hard-to-reverse: force-push,
  `git reset --hard`, rewriting history, deleting branches, merging to
  `main`, or removing dependencies - unless the user explicitly asks for
  that specific action.
- Do not proactively build/check APK status after every change (the user
  asked to stop this); CI still runs automatically on push.
