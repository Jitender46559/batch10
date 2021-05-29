try{
    node{
        def mavenHome
        def mavenCMD
        def docker
        def dockerCMD
        def tagName = "1.0"
        
        stage('Preparation'){
            echo "Preparing the Jenkins environment with required tools..."
            mavenHome = tool name: 'Maven', type: 'maven'
            mavenCMD = "${mavenHome}/bin/mvn"
            docker = tool name: 'Docker', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'
            dockerCMD = "$docker/bin/docker"
        }
        
        stage('git checkout'){
            echo "Checking out the code from git repository..."
            git 'https://github.com/Jitender46559/batch10.git'
        }
        
        stage('Build, Test and Package'){
            echo "Building the SpringBoot application..."
            sh "${mavenCMD} clean package"
        }
        
        stage('Sonar Scan'){
            echo "Scanning application for vulnerabilities..."
            //sh "${mavenCMD} sonar:sonar -Dsonar.host.url=http://xx.xxx.xx.xx:9000"
        }
        
        stage('Integration test'){
            echo "Executing Regression Test Suits..."
            // command to execute selenium test suits
        }
        
        stage('publish report'){
            echo " Publishing HTML report.."
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: ''])
        }
        
        stage('Build Docker Image'){
            echo "Building docker image for SpringBoot application ..."
            sh "${dockerCMD} build -t jitender46559/batch10:${tagName} ."
        }
        
        stage("Push Docker Image to Docker Registry"){
            echo "Pushing image to docker hub"
            withCredentials([usernamePassword(credentialsId: 'Docker', passwordVariable: 'userPass', usernameVariable: 'userName')]) {
                sh "${dockerCMD} login -u ${userName} -p ${userPass}"
                sh "${dockerCMD} push jitender46559/batch10:${tagName}"
            }
        }
        
        stage('Clean up'){
            echo "Cleaning up the workspace..."
            cleanWs()
        }
    }
}
catch(Exception err){
    echo "Exception occured..."
    currentBuild.result="FAILURE"
    //send an failure email notification to the user.
}
finally {
    (currentBuild.result!= "ABORTED") && node("master") {
        echo "finally gets executed and end an email notification for every build"
        emailext body: 'Docker image for SpringBoot application has been Successfully Deployed', subject: 'Build Result', to: 'jkumar46559@gmail.com'
    }
    
}
