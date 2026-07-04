# Engineering handoff — {{component_or_flow}}

> Figma Dev Mode already covers spacing, type, color, tokens, and code snippets. This document
> covers what Figma doesn't: behavior, states, logic, content rules, and accessibility.
> Mark anything **inferred** rather than certain.

## Happy path
{{describe_primary_interaction}}

## States (every interactive element)
| Element | Loading | Error | Empty | Disabled | Focus | Success |
|---------|---------|-------|-------|----------|-------|---------|
| {{el}}  |         |       |       |          |       |         |

## Conditional logic (when does each element show vs. hide)
- {{rule}}

## Validation rules & error messages
- {{field}}: {{rule}} → "{{message}}"

## Accessibility
- Focus order: {{order}}
- Labels / ARIA: {{labels}}
- Announcements (live regions): {{announcements}}

## Open questions / inferred (verify with design)
- [ ] {{inferred_item}}

**Status:** ☐ Ready for dev
