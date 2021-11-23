using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Android;
using System;
using UnityEngine.SceneManagement;
public class ReadingSpreeSeq : MonoBehaviour
{
    public Text score;
    public GameObject nextCanvas;
    public Button buttonCorrect;
    public Button buttonWrong;
    public Image check;
    public Image wrong;
    private bool wrongf;
    private bool checkf;
    private UnityMessageManager unitymanager;
    public String message;
    public bool isLast = false;
    // Start is called before the first frame update
    void Start()
    {
        buttonCorrect.onClick.AddListener(showCheck);
        buttonWrong.onClick.AddListener(showWrong);
        check.gameObject.SetActive(false);
        wrong.gameObject.SetActive(false);
        unitymanager = GetComponent<UnityMessageManager>();
        sendMessage(message);
    }

    //private void FixedUpdate()
    //{
    //    sendMessage(message);
    //}
    public void sendMessage(String message)
    {
        unitymanager.SendMessageToFlutter(message);
    }
    // Update is called once per frame
    void Update()
    {
        if (Application.platform == RuntimePlatform.Android)
        {
            if (Input.GetKey(KeyCode.Escape))
            {
                // Insert Code Here (I.E. Load Scene, Etc)
                // OR Application.Quit();
                SceneManager.LoadScene("Homescreen");
                return;
            }
        }
    }

    public void showCheck()
    {
        check.gameObject.SetActive(true);
        checkf = true;
        if (wrongf)
        {
            wrong.gameObject.SetActive(false);
        }
        int number = Int32.Parse(score.text.ToString()) + 5;
        score.text = number.ToString();
        SoundManagerScript.playSound("answerCorrect");
        StartCoroutine(ExecuteAfterTime(0.1f));

    }
    public void showWrong()
    {
        wrong.gameObject.SetActive(true);
        wrongf = true;
        if (checkf)
        {
            check.gameObject.SetActive(false);
        }
        SoundManagerScript.playSound("answerWrong");
    }

    IEnumerator ExecuteAfterTime(float time)
    {
        int i = 0;
        Debug.Log(" " + i++);
        unitymanager.SendMessageToFlutter("Button off");
        yield return new WaitForSeconds(time);
        check.gameObject.SetActive(false);
        wrong.gameObject.SetActive(false);
        this.gameObject.SetActive(false);
        if(isLast)
            SceneManager.LoadScene("ReadingSpree");
        else
          nextCanvas.SetActive(true);
    }
}
