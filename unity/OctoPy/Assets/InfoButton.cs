using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class InfoButton : MonoBehaviour
{
    // Start is called before the first frame update
    private bool info = false;
    private UnityMessageManager unitymanager;
    private int i = 0;
    public Button infoButton;
    public string sceneNumber;
    void Start()
    {
        unitymanager = GetComponent<UnityMessageManager>();
        infoButton.onClick.AddListener(pressInfo);
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
            unitymanager.SendMessageToFlutter("Button off");
            info = false;
        }
    }
}
