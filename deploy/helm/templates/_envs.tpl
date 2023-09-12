{{/* vim: set filetype=mustache: */}}
{{/*
Environment variables for web and worker containers
*/}}
{{- define "app.envs" }}
env:
  {{ if .Values.postgresql.enabled }}
  - name: POSTGRES_USER
    valueFrom:
      secretKeyRef:
        name: {{ template "app.fullname" . }}
        key: postgresqlUsername
  - name: POSTGRES_PASSWORD
    valueFrom:
      secretKeyRef:
        name: {{ template "app.fullname" . }}
        key: postgresqlPassword
  - name: POSTGRES_HOST
    value: {{ printf "%s-%s" .Release.Name "postgresql" | trunc 63 | trimSuffix "-" }}
  - name: POSTGRES_DATABASE
    valueFrom:
      secretKeyRef:
        name: {{ template "app.fullname" . }}
        key: postgresqlDatabase
  {{ else }}
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
  - name: POSTGRES_DATABASE
    valueFrom:
      secretKeyRef:
        name: rds-instance-output
        key: database_name
  {{ end }}
  - name: SECRET_KEY_BASE
    valueFrom:
      secretKeyRef:
        name: {{ template "app.fullname" . }}
        key: secretKeyBase
  - name: SENTRY_DSN
    valueFrom:
      secretKeyRef:
        name: {{ template "app.fullname" . }}
        key: sentryDsn
  - name: RAILS_ENV
    value: production
  - name: RAILS_LOG_TO_STDOUT
    value: 'true'
  - name: HOST
    valueFrom:
      secretKeyRef:
        name: {{ template "app.fullname" . }}
        key: deployHost
  - name: CCMS_SOA_AWS_GATEWAY_API_KEY
    valueFrom:
      secretKeyRef:
        name: {{ template "app.fullname" . }}
        key: ccmsSoaAwsGatewayApiKey
  - name: CCMS_SOA_CLIENT_USERNAME
    valueFrom:
      secretKeyRef:
        name: {{ template "app.fullname" . }}
        key: ccmsSoaClientUsername
  - name: CCMS_SOA_CLIENT_PASSWORD_TYPE
    valueFrom:
      secretKeyRef:
        name: {{ template "app.fullname" . }}
        key: ccmsSoaClientPasswordType
  - name: CCMS_SOA_CLIENT_PASSWORD
    valueFrom:
      secretKeyRef:
        name: {{ template "app.fullname" . }}
        key: ccmsSoaClientPassword
  - name: CCMS_SOA_USER_ROLE
    valueFrom:
      secretKeyRef:
        name: {{ template "app.fullname" . }}
        key: ccmsSoaUserRole
  - name: CCMS_SOA_GET_COMMON_ORG_WSDL
    valueFrom:
      secretKeyRef:
        name: {{ template "app.fullname" . }}
        key: ccmsSoaGetCommonOrgWsdl
  - name: CCMS_SOA_PROVIDER_USERNAME
    valueFrom:
      secretKeyRef:
        name: {{ template "app.fullname" . }}
        key: ccmsSoaProviderUsername
{{- end }}
