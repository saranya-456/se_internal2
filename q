node {
    def repoUrl = 'https://github.com/ssvkotamraju/MavenJava.git'
    def branch = 'main'

    try {
        stage('Checkout') {
            git url: repoUrl, branch: branch
        }

        stage('Build') {
            sh 'mvn clean install'

        }

        stage('Test') {
            sh 'mvn test'  
        }
        stage('Deploy') {
            echo 'Deployment steps here...'
        }

    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        throw e
    } finally {
        archiveArtifacts allowEmptyArchive: true, artifacts: '**/target/*.jar, **/target/*.war' 

    }
}
