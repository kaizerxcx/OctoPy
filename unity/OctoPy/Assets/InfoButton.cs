using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class InfoButton : MonoBehaviour
{
    // Start is called before the first frame update
    private bool info = false;
    private UnityMessageManager unitymanager;
    private int i = 0;
    public Button infoButton;
    public Button backButton;
    public string sceneNumber;
    public bool isReading = false;
    void Start()
    {
        unitymanager = GetComponent<UnityMessageManager>();
        infoButton.onClick.AddListener(pressInfo);
        backButton.onClick.AddListener(exitVid);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void pressInfo()
    {
        if (!info)
        {
            unitymanager.SendMessageToFlutter("Button on "+sceneNumber);
            info = true;
        }
        else
        {
            if (!isReading)
                unitymanager.SendMessageToFlutter("Button off");
            else
                unitymanager.SendMessageToFlutter("Button off reading");
            info = false;
        }
    }

    public void exitVid()
    {
       if(!isReading)
        unitymanager.SendMessageToFlutter("Button off");
       else
            unitymanager.SendMessageToFlutter("Button off reading");
        SceneManager.LoadScene("Homescreen");

    }
}
