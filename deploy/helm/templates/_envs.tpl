{{/* vim: set filetype=mustache: */}}
{{/*
Environment variables for web and worker containers
*/}}
{{- define "app.envs" }}
env:
  - name: POSTGRES_USER
    valueFrom:
      secretKeyRef:
        name: rds-instance-output
        key: database_username
  - name: POSTGRES_PASSWORD
    valueFrom:
      secretKeyRef:
        name: rds-instance-output
        key: database_password
  - name: POSTGRES_HOST
    valueFrom:
      secretKeyRef:
        name: rds-instance-output
        key: rds_instance_address
  {{ if .Values.branch_builder.enabled }}
  - name: POSTGRES_DATABASE
    value: {{ .Values.branch_builder.database_name | quote }}
  {{ else }}
  - name: POSTGRES_DATABASE
    valueFrom:
      secretKeyRef:
        name: rds-instance-output
        key: database_name
  {{ end }}
  - name: SECRET_KEY_BASE
    valueFrom:
      secretKeyRef:
        name: lfa-secrets
        key: secretKeyBase
  - name: SENTRY_DSN
    valueFrom:
      secretKeyRef:
        name: lfa-secrets
        key: sentryDsn
  - name: RAILS_ENV
    value: production
  - name: RAILS_LOG_TO_STDOUT
    value: 'true'
  - name: HOST
    value: {{ .Values.deploy.host | quote }}
{{- end }}
