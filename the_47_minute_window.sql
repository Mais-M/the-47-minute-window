CREATE DATABASE thief_investigation;
 
USE thief_investigation;

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    sender_account VARCHAR(50),
    recipient_account VARCHAR(50),
    amount_usd DECIMAL(15,2),
    transaction_time DATETIME,
    channel VARCHAR(50),
    status VARCHAR(30)
);

INSERT INTO transactions VALUES
(1001, 'RESERVE_001', 'ACC_8821', 120000000, '2026-08-18 02:13:07', 'BANK_TRANSFER', 'COMPLETED'),
(1002, 'RESERVE_001', 'ACC_7712', 95000000,  '2026-08-18 02:14:32', 'BANK_TRANSFER', 'COMPLETED'),
(1003, 'RESERVE_001', 'ACC_6620', 72000000,  '2026-08-18 02:16:04', 'BANK_TRANSFER', 'COMPLETED'),
(1004, 'RESERVE_001', 'ACC_5541', 100000000, '2026-08-18 02:18:51', 'BANK_TRANSFER', 'COMPLETED'),
(1005, 'RESERVE_001', 'ACC_4410', 100000000, '2026-08-18 02:24:44', 'BANK_TRANSFER', 'COMPLETED'),

(1006, 'ACC_8821', 'PAYMENT_193', 60000000, '2026-08-18 02:20:10', 'PAYMENT_SERVICE', 'COMPLETED'),
(1007, 'ACC_8821', 'PAYMENT_193', 60000000, '2026-08-18 02:21:15', 'PAYMENT_SERVICE', 'COMPLETED'),

(1008, 'PAYMENT_193', 'EXCHANGE_72', 40000000, '2026-08-18 02:27:03', 'CRYPTO_EXCHANGE', 'COMPLETED'),
(1009, 'PAYMENT_193', 'EXCHANGE_72', 40000000, '2026-08-18 02:28:11', 'CRYPTO_EXCHANGE', 'COMPLETED'),
(1010, 'PAYMENT_193', 'EXCHANGE_72', 40000000, '2026-08-18 02:29:22', 'CRYPTO_EXCHANGE', 'COMPLETED');

SELECT *
FROM transactions;

SELECT
    transaction_id,
    sender_account,
    recipient_account,
    amount_usd,
    transaction_time,
    channel
FROM transactions
WHERE sender_account = 'RESERVE_001'
ORDER BY transaction_time;

SELECT
    SUM(amount_usd) AS total_stolen
FROM transactions
WHERE sender_account = 'RESERVE_001';

SELECT
    MIN(transaction_time) AS first_transfer,
    MAX(transaction_time) AS last_transfer,
    TIMESTAMPDIFF(
        MINUTE,
        MIN(transaction_time),
        MAX(transaction_time)
    ) AS theft_duration_minutes
FROM transactions
WHERE sender_account = 'RESERVE_001';

SELECT
    COUNT(*) AS number_of_transfers,
    SUM(amount_usd) AS total_stolen,
    AVG(amount_usd) AS average_transfer
FROM transactions
WHERE sender_account = 'RESERVE_001';

SELECT
    recipient_account,
    COUNT(*) AS transfers_received,
    SUM(amount_usd) AS total_received,
    MIN(transaction_time) AS first_received,
    MAX(transaction_time) AS last_received
FROM transactions
GROUP BY recipient_account
ORDER BY total_received DESC;

SELECT
    recipient_account,
    COUNT(*) AS transfers_received,
    SUM(amount_usd) AS total_received
FROM transactions
GROUP BY recipient_account
HAVING SUM(amount_usd) >= 50000000
ORDER BY total_received DESC;

SELECT
    t1.recipient_account AS first_destination,
    t2.recipient_account AS second_destination,
    t1.amount_usd AS original_amount,
    t2.amount_usd AS forwarded_amount,
    t2.transaction_time
FROM transactions t1
JOIN transactions t2
    ON t1.recipient_account = t2.sender_account
WHERE t1.sender_account = 'RESERVE_001'
ORDER BY t2.transaction_time;

WITH RECURSIVE money_trail AS (

    SELECT
        transaction_id,
        sender_account,
        recipient_account,
        amount_usd,
        transaction_time,
        1 AS hop
    FROM transactions
    WHERE sender_account = 'RESERVE_001'

    UNION ALL

    SELECT
        t.transaction_id,
        t.sender_account,
        t.recipient_account,
        t.amount_usd,
        t.transaction_time,
        mt.hop + 1
    FROM transactions t

    JOIN money_trail mt
        ON t.sender_account = mt.recipient_account

    WHERE mt.hop < 5
)

SELECT *
FROM money_trail
ORDER BY hop, transaction_time;

CREATE TABLE access_logs (
    log_id INT PRIMARY KEY,
    user_id VARCHAR(30),
    device_id VARCHAR(30),
    ip_address VARCHAR(45),
    event_time DATETIME,
    event_type VARCHAR(50),
    success BOOLEAN
);

INSERT INTO access_logs VALUES
(1, 'USER_017', 'DEVICE_8841', '10.0.4.17', '2026-08-18 02:11:48', 'LOGIN_SUCCESS', TRUE),

(2, 'USER_017', 'DEVICE_8841', '10.0.4.17', '2026-08-18 02:12:03', 'PRIVILEGED_SESSION', TRUE),

(3, 'USER_017', 'DEVICE_8841', '10.0.4.17', '2026-08-18 02:13:07', 'PAYMENT_AUTHORIZATION', TRUE),

(4, 'USER_005', 'DEVICE_4412', '10.0.8.21', '2026-08-18 01:55:00', 'LOGIN_SUCCESS', TRUE),

(5, 'USER_009', 'DEVICE_7711', '10.0.9.31', '2026-08-18 03:20:00', 'LOGIN_SUCCESS', TRUE);

SELECT *
FROM access_logs
ORDER BY event_time;

SELECT
    user_id,
    device_id,
    ip_address,
    event_time,
    event_type
FROM access_logs
WHERE event_time BETWEEN
      '2026-08-18 02:00:00'
      AND '2026-08-18 02:15:00'
ORDER BY event_time;

CREATE TABLE permission_changes (
    permission_id INT PRIMARY KEY,
    user_id VARCHAR(30),
    changed_by VARCHAR(30),
    privilege VARCHAR(50),
    granted_at DATETIME,
    revoked_at DATETIME
);

INSERT INTO permission_changes VALUES
(
    1,
    'USER_017',
    'USER_003',
    'PAYMENT_OVERRIDE',
    '2026-05-18 01:43:00',
    '2026-05-18 02:30:00'
),

(
    2,
    'USER_005',
    'USER_003',
    'REPORT_VIEW',
    '2026-05-18 09:00:00',
    '2026-05-18 17:00:00'
);

CREATE TABLE devices (
    device_id VARCHAR(30) PRIMARY KEY,
    assigned_user VARCHAR(30),
    device_type VARCHAR(50),
    is_corporate BOOLEAN
);

INSERT INTO devices VALUES
('DEVICE_8841', 'USER_017', 'PERSONAL_LAPTOP', FALSE),
('DEVICE_4412', 'USER_005', 'CORPORATE_LAPTOP', TRUE),
('DEVICE_7711', 'USER_009', 'CORPORATE_LAPTOP', TRUE);

SELECT
    a.user_id,
    a.device_id,
    d.assigned_user,
    d.device_type,
    d.is_corporate,
    a.event_time,
    a.event_type
FROM access_logs a
JOIN devices d
    ON a.device_id = d.device_id
ORDER BY a.event_time;

SELECT
    a.user_id,
    a.device_id,
    d.device_type,
    a.event_time,
    a.event_type
FROM access_logs a
JOIN devices d
    ON a.device_id = d.device_id
WHERE d.is_corporate = FALSE
AND a.event_type IN (
    'PRIVILEGED_SESSION',
    'PAYMENT_AUTHORIZATION'
);

CREATE TABLE interview_claims (
    claim_id INT PRIMARY KEY,
    user_id VARCHAR(30),
    claim_start DATETIME,
    claim_end DATETIME,
    claimed_activity VARCHAR(255)
);

INSERT INTO interview_claims VALUES
(
    1,
    'USER_017',
    '2026-08-18 00:00:00',
    '2026-08-18 06:00:00',
    'At home asleep'
),

(
    2,
    'USER_005',
    '2026-08-18 01:00:00',
    '2026-08-18 04:00:00',
    'Working scheduled maintenance'
);

SELECT
    i.user_id,
    i.claimed_activity,
    i.claim_start,
    i.claim_end,
    a.event_time,
    a.event_type,
    a.device_id
FROM interview_claims i

JOIN access_logs a
    ON i.user_id = a.user_id

WHERE a.event_time
      BETWEEN i.claim_start AND i.claim_end

ORDER BY
    i.user_id,
    a.event_time;
    
    SELECT
    i.user_id,
    i.claimed_activity,
    COUNT(a.log_id) AS contradictory_events
FROM interview_claims i

JOIN access_logs a
    ON i.user_id = a.user_id

WHERE a.event_time
      BETWEEN i.claim_start AND i.claim_end

AND a.event_type IN (
    'LOGIN_SUCCESS',
    'PRIVILEGED_SESSION',
    'PAYMENT_AUTHORIZATION'
)

GROUP BY
    i.user_id,
    i.claimed_activity

HAVING COUNT(a.log_id) > 0;

SELECT
    a.user_id,
    a.device_id,
    d.device_type,
    d.is_corporate,
    a.event_time,
    a.event_type,
    p.privilege,
    p.granted_at,
    p.revoked_at
FROM access_logs a

JOIN devices d
    ON a.device_id = d.device_id

LEFT JOIN permission_changes p
    ON a.user_id = p.user_id

WHERE a.event_type IN (
    'PRIVILEGED_SESSION',
    'PAYMENT_AUTHORIZATION'
)

ORDER BY a.event_time;

SELECT
    'ACCESS' AS evidence_type,
    user_id AS actor,
    event_time,
    event_type AS description
FROM access_logs
WHERE user_id = 'USER_017'

UNION ALL

SELECT
    'TRANSACTION' AS evidence_type,
    sender_account AS actor,
    transaction_time AS event_time,
    CONCAT(
        'Transferred $',
        FORMAT(amount_usd, 0),
        ' to ',
        recipient_account
    ) AS description
FROM transactions
WHERE sender_account = 'RESERVE_001'

ORDER BY event_time;
