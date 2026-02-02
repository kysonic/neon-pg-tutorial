# Basic PostgreSQL Connection Examples

This directory contains simple examples for connecting to PostgreSQL using different programming languages.

## Prerequisites

- A PostgreSQL database (local installation or Neon serverless)
- Connection string/credentials
- Programming language runtime installed

## Connection String Format

For PostgreSQL (including Neon):
```
postgresql://[user]:[password]@[host]:[port]/[database]?sslmode=require
```

Example:
```
postgresql://user:password@ep-example-123.us-east-1.aws.neon.tech/neondb?sslmode=require
```

## Examples

- [Node.js Example](nodejs-example.js) - Connect using the `pg` library
- [Python Example](python-example.py) - Connect using `psycopg2`

## Getting Your Neon Connection String

1. Sign up at [neon.com](https://neon.com)
2. Create a new project
3. Copy your connection string from the dashboard
4. Replace the placeholder in the examples with your actual connection string

## Security Note

**Never commit your connection strings or credentials to version control!** 

Use environment variables:
```bash
export DATABASE_URL="postgresql://user:password@host/database"
```

Or use a `.env` file (and add it to `.gitignore`):
```
DATABASE_URL=postgresql://user:password@host/database
```
