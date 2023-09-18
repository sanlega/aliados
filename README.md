1. **Topics Design**:

   Break down the MQTT topics for clarity and scalability:

   - `aliados/tests/activated`: 
     - Published by: ESP32 Arduino units
     - Payload example: `{"testID": "test123", "timestamp": "2023-09-17T14:34:56Z"}`

   - `aliados/tests/completed`: 
     - Published by: ESP32 Arduino units
     - Payload example: `{"testID": "test123", "playerName": "John", "timeToFinish": "15m", "retries": 2, "completedOnTime": true}`

   - `aliados/tests/settings`: 
     - Published by: Control Panel Webpage
     - Payload example: `{"testID": "test123", "maxTime": "30m", "iterations": 5}`
     
     - Subscribed by: ESP32 Arduino units to update test settings

2. **Dockerized Services**:

   - **Mosquitto MQTT Broker**: For handling all PUB/SUB operations.
     
   - **Node-RED**: For managing and processing MQTT messages and interfacing with Grafana. Node-RED can process MQTT data and update databases, run logic, etc.

   - **Grafana**: For visualizing data and possibly interfacing with the user. Grafana can present the test results in a user-friendly manner.

   - **Database (like InfluxDB)**: Store game results, player statistics, and any other historical data you might want to keep or visualize later.

3. **Flow**:

   1. **Game Activation**:
      - ESP32 activates a game/test and publishes a message to `aliados/tests/activated`.
      - Node-RED subscribes to this topic, processes the message, and may store the game activation data in the database.
   
   2. **Game Completion**:
      - ESP32 publishes the game results to `aliados/tests/completed`.
      - Node-RED processes the results, updates the database, and can trigger visual updates on Grafana.

   3. **Settings Change**:
      - Admin/user adjusts settings on the Grafana (or separate) interface.
      - These changes are published to `aliados/tests/settings`.
      - ESP32 units subscribe to this topic and adjust their game settings accordingly.

   4. **Visualization**:
      - Grafana reads from the database and provides visual stats, charts, and any other necessary feedback about games/tests.

4. **Security**:
   
   - Encryption: Make sure the MQTT messages are encrypted, especially if running over public networks.
   - Authentication: Only allow authorized devices to publish/subscribe to your MQTT topics.
   - Database Security: Ensure only authorized services can access and modify the database.

5. **Scalability**:
   
   - You might want to consider breaking down topics even further, based on different room designs, different locations (if you expand), or different game types.

6. **Web Interface**:
   
   - Should be mobile responsive to allow users to access easily from their phones.
   - Should have both admin and user sections. The admin section for changing game settings and viewing overall statistics. The user section for viewing their game stats.

By combining Docker with Mosquitto, Node-RED, and Grafana, you'll have a powerful, scalable, and flexible architecture to support the operation.
