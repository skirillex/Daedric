import unittest
import subprocess
import json




class TestIfScoreDeployed(unittest.TestCase):

    def test_deployed_score_post(self):

        # tests if score was deployed by finding it's address in text file
        score_address = ""
        with open('config/yeouido/score_address.txt', "r") as file:
           score_address = file.read()
        
        print("Test Successful! Testnet Score Address Found!: "+ score_address)



        test_pass_flag = False

        if len(score_address) > 1:
            test_pass_flag = True

        self.assertTrue(test_pass_flag)

class TestScorePost(unittest.TestCase):

    def test_deployed_score_post(self):
        result = subprocess.run(["./scripts/score/post.sh","-n", "yeouido", "-p", "100"], capture_output=True)

        jsonS = result.stdout
        jstring = jsonS.decode()

        #cut up output so it can be decoded
        split = jstring.split('->')
        split2 = split[2].split('"result": ')
        split3 = split2[1].split('"id"')

        data = json.loads(split3[0].strip()[:-1])

        print("Test Successful! DApp is able to Post on Testnet")
        test_pass_flag = False

        if data['to'] != None:
            test_pass_flag = True

        self.assertTrue(test_pass_flag)

class TestScorePeek(unittest.TestCase):

    def test_deployed_score_peek(self):
        result = subprocess.run(["./scripts/score/peek.sh","-n", "yeouido"], capture_output=True)

        jsonS = result.stdout
        jstring = jsonS.decode()

        #cut up output so it can be decoded
        split = jstring.split('>')
        split2 = split[2].split('"result": ')
        split3 = split2[1].split('"id"')

        data = json.loads(split3[0].strip()[:-1])

        print("Test Successful! Able to Peek DApp on Testnet")


        test_pass_flag = False

        if data['timestamp'] != None:
            test_pass_flag = True

        self.assertTrue(test_pass_flag)