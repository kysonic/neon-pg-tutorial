#!/usr/bin/env python3
"""
Basic PostgreSQL Connection Example with Python
Install psycopg2: pip install psycopg2-binary python-dotenv
"""

import os
import psycopg2
from psycopg2.extras import RealDictCursor
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Connection configuration
# Use environment variable for security
DATABASE_URL = os.getenv('DATABASE_URL', 'postgresql://user:password@localhost:5432/mydb')

def connect_and_query():
    """Connect to PostgreSQL and run example queries"""
    conn = None
    cursor = None
    
    try:
        # Connect to the database
        conn = psycopg2.connect(DATABASE_URL)
        print('✓ Connected to PostgreSQL database')
        
        # Create a cursor with dictionary-like results
        cursor = conn.cursor(cursor_factory=RealDictCursor)
        
        # Execute a simple query
        cursor.execute('SELECT version()')
        version = cursor.fetchone()
        print('\nPostgreSQL Version:')
        print(version['version'])
        
        # Example: Create a simple table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS users (
                id SERIAL PRIMARY KEY,
                name VARCHAR(100) NOT NULL,
                email VARCHAR(100) UNIQUE NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        conn.commit()
        print('\n✓ Table "users" created (if it didn\'t exist)')
        
        # Example: Insert a record (with ON CONFLICT to make it idempotent)
        cursor.execute(
            'INSERT INTO users (name, email) VALUES (%s, %s) ON CONFLICT (email) DO NOTHING RETURNING *',
            ('Jane Smith', 'jane@example.com')
        )
        inserted_user = cursor.fetchone()
        conn.commit()
        if inserted_user:
            print('\n✓ Inserted user:')
            print(dict(inserted_user))
        else:
            print('\n✓ User already exists (skipped insertion)')
        
        # Example: Query records
        cursor.execute('SELECT * FROM users')
        all_users = cursor.fetchall()
        print('\nAll users:')
        for user in all_users:
            print(dict(user))
        
        # Example: Count records
        cursor.execute('SELECT COUNT(*) as count FROM users')
        count_result = cursor.fetchone()
        print(f'\nTotal users: {count_result["count"]}')
        
    except psycopg2.Error as error:
        print(f'Error: {error}')
        if conn:
            conn.rollback()
    
    finally:
        # Always close cursor and connection
        if cursor:
            cursor.close()
        if conn:
            conn.close()
            print('\n✓ Connection closed')

if __name__ == '__main__':
    connect_and_query()

"""
Expected Output:
✓ Connected to PostgreSQL database

PostgreSQL Version:
PostgreSQL 15.x on x86_64-pc-linux-gnu...

✓ Table "users" created (if it didn't exist)
✓ Inserted user:
{'id': 1, 'name': 'Jane Smith', 'email': 'jane@example.com', 'created_at': datetime...}

All users:
{'id': 1, 'name': 'Jane Smith', 'email': 'jane@example.com', 'created_at': datetime...}

Total users: 1
✓ Connection closed
"""
