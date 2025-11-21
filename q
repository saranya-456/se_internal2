node {
    // Define the workspace and check out code from GitHub
    def repoUrl = 'https://github.com/yourusername/online-recruitment-system.git'
    def branch = 'main' // Change to the appropriate branch name

    try {
        // Checkout the code from GitHub repository
        stage('Checkout') {
            git url: repoUrl, branch: branch
        }

        // Build stage (this will vary depending on your project type, e.g., Java, Node.js, etc.)
        stage('Build') {
            // Example for a Node.js application
            sh 'npm install' // Install dependencies

            // Or for a Java project using Maven
            // sh 'mvn clean install'

            // You can customize this to fit your build tool (Gradle, Ant, etc.)
        }

        // Run tests
        stage('Test') {
            // Run unit tests
            sh 'npm test'  // Replace with 'mvn test' for Java or your relevant test command
        }

        // You can include other stages like 'Deploy' depending on your project
        // Example deploy stage if necessary
        stage('Deploy') {
            // Your deployment steps here
            // e.g., Deploy to server or cloud platform
            echo 'Deployment steps here...'
        }

    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        throw e
    } finally {
        // Post-build actions (archiving test results, sending notifications, etc.)
        archiveArtifacts allowEmptyArchive: true, artifacts: '**/target/*.jar, **/target/*.war'  // Example for Maven
        junit '**/target/test-*.xml'  // For Java projects (JUnit test results)

        // Example for sending email notifications or Slack notifications
        // mail to: 'your-email@example.com', subject: "Build Status: ${currentBuild.currentResult}", body: "Build details here"
    }
}
