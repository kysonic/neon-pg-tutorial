// Basic PostgreSQL Connection Example with Node.js
// Install the pg library: npm install pg dotenv

const { Client } = require('pg');
require('dotenv').config();

// Connection configuration
// Use environment variable for security
const connectionString = process.env.DATABASE_URL || 'postgresql://user:password@localhost:5432/mydb';

const client = new Client({
  connectionString: connectionString,
  ssl: {
    rejectUnauthorized: false // Required for most cloud PostgreSQL providers
  }
});

async function connectAndQuery() {
  try {
    // Connect to the database
    await client.connect();
    console.log('✓ Connected to PostgreSQL database');

    // Execute a simple query
    const result = await client.query('SELECT version()');
    console.log('\nPostgreSQL Version:');
    console.log(result.rows[0].version);

    // Example: Create a simple table
    await client.query(`
      CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);
    console.log('\n✓ Table "users" created (if it didn\'t exist)');

    // Example: Insert a record
    const insertResult = await client.query(
      'INSERT INTO users (name, email) VALUES ($1, $2) RETURNING *',
      ['John Doe', 'john@example.com']
    );
    console.log('\n✓ Inserted user:');
    console.log(insertResult.rows[0]);

    // Example: Query records
    const queryResult = await client.query('SELECT * FROM users');
    console.log('\nAll users:');
    console.log(queryResult.rows);

    // Example: Count records
    const countResult = await client.query('SELECT COUNT(*) FROM users');
    console.log(`\nTotal users: ${countResult.rows[0].count}`);

  } catch (error) {
    console.error('Error:', error.message);
  } finally {
    // Always close the connection
    await client.end();
    console.log('\n✓ Connection closed');
  }
}

// Run the example
connectAndQuery();

/*
 * Expected Output:
 * ✓ Connected to PostgreSQL database
 * 
 * PostgreSQL Version:
 * PostgreSQL 15.x on x86_64-pc-linux-gnu...
 * 
 * ✓ Table "users" created (if it didn't exist)
 * ✓ Inserted user:
 * { id: 1, name: 'John Doe', email: 'john@example.com', created_at: 2024-... }
 * 
 * All users:
 * [ { id: 1, name: 'John Doe', email: 'john@example.com', created_at: 2024-... } ]
 * 
 * Total users: 1
 * ✓ Connection closed
 */
