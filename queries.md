When building a web app for the skating club database, you’ll likely need to query it for various user interactions and administrative tasks. Below are ten realistic scenarios where you’d query the database, along with example SQL queries to address each. These scenarios assume typical web app functionality like user management, resource tracking, payment processing, and reporting.

### 1. User Login Authentication

**Scenario**: A user attempts to log in with their email and password. You need to verify their credentials.
**Query**:

```sql
SELECT id, fullname, category FROM MEMBERS
WHERE email = 'caroline@eldohub.co.ke' AND password = 'jfshjfnsdjn';
```

**Purpose**: Authenticate the user and retrieve their ID and details for session management.

### 2. Display Available Resources

**Scenario**: A user wants to browse available skating gear or equipment to borrow.
**Query**:

```sql
SELECT name, size, category FROM RESOURCES
WHERE availability = 'available';
```

**Purpose**: Show a list of resources that can be issued to members.

### 3. Issue a Resource to a Member

**Scenario**: A member requests to borrow a resource (e.g., a skateboard). You need to check if it’s available and record the issuance.
**Query** (to check availability and insert issuance):

```sql
-- Check if resource is available
SELECT availability FROM RESOURCES WHERE id = 5;
-- If available, insert issuance and update resource
INSERT INTO RESOURCE_ISSUANCE (resource_id, member_id, status, expected_return_date)
VALUES (5, 1, 'issued', '2025-08-10');
UPDATE RESOURCES SET availability = 'unavailable' WHERE id = 5;
```

**Purpose**: Ensure the resource is available, record the issuance, and update its status.

### 4. View a Member’s Borrowed Resources

**Scenario**: A member wants to see all resources they’ve currently borrowed.
**Query**:

```sql
SELECT r.name, r.size, r.category, ri.expected_return_date
FROM RESOURCE_ISSUANCE ri
JOIN RESOURCES r ON ri.resource_id = r.id
WHERE ri.member_id = 1 AND ri.status = 'issued';
```

**Purpose**: Display a member’s active borrowed items with return dates.

### 5. Process a Member’s Payment

**Scenario**: A member makes a payment for their subscription. You need to record it and check their payment status.
**Query**:

```sql
INSERT INTO PAYMENTS (member_id, amount, status, subscription_year)
VALUES (3, 50.00, 'partially_paid', 2025);
-- Verify updated payment status
SELECT amount, status FROM PAYMENTS
WHERE member_id = 3 AND subscription_year = 2025;
```

**Purpose**: Record the payment and confirm the member’s payment status.

### 6. List Overdue Resources

**Scenario**: An admin wants to identify members with overdue resources (past expected return date).
**Query**:

```sql
SELECT m.fullname, r.name, ri.expected_return_date
FROM RESOURCE_ISSUANCE ri
JOIN MEMBERS m ON ri.member_id = m.id
JOIN RESOURCES r ON ri.resource_id = r.id
WHERE ri.status = 'issued' AND ri.expected_return_date < CURDATE();
```

**Purpose**: Generate a report of overdue items for follow-up.

### 7. Member Profile Update

**Scenario**: A member updates their email or password in their profile settings.
**Query**:

```sql
UPDATE MEMBERS
SET email = 'new.email@example.com', password = 'newpass123'
WHERE id = 2;
```

**Purpose**: Allow members to update their account details securely.

### 8. Generate Payment Reports for a Year

**Scenario**: An admin needs a summary of payment statuses for all members in 2025.
**Query**:

```sql
SELECT m.fullname, p.amount, p.status, p.subscription_year
FROM PAYMENTS p
JOIN MEMBERS m ON p.member_id = m.id
WHERE p.subscription_year = 2025
ORDER BY p.status, m.fullname;
```

**Purpose**: Provide a financial overview for subscription management.

### 9. Check Member Category for Access Control

**Scenario**: The app restricts certain features (e.g., priority resource access) to gold members.
**Query**:

```sql
SELECT category FROM MEMBERS WHERE id = 1;
```

**Purpose**: Verify the member’s category to grant or deny access to specific app features.

### 10. Track Resource Usage History

**Scenario**: An admin wants to see the borrowing history of a specific resource to assess its demand.
**Query**:

```sql
SELECT m.fullname, ri.date, ri.expected_return_date, ri.status
FROM RESOURCE_ISSUANCE ri
JOIN MEMBERS m ON ri.member_id = m.id
WHERE ri.resource_id = 5
ORDER BY ri.date DESC;
```

**Purpose**: Analyze how often a resource is borrowed to inform inventory decisions.

These queries cover common web app functionalities like user authentication, resource management, payment tracking, and reporting. They assume a front-end interface where users input data (e.g., member IDs, resource IDs, or dates) that would be parameterized to prevent SQL injection. Let me know if you need help with implementing these in a specific web app framework or with additional scenarios!
