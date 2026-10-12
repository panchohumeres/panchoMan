### GPT4All Python Backend Examples

1. [Chat Examples](gpt4all_chat_examples.ipynb)
		- Standard chat session.
		- Chat with persistent history.
		- Chat with sliding window memory (dynamically delete part of the chat history for freeing memory)
2. [Chat Templates](gpt4all_chat_templates.ipynb)
	How to load chat templates from the local model file for rendering prompts.
 3. [RAG](gpt4all-rag.ipynb)
	 RAG (Retrieval Augmented Generation) using chromaDB client as vector store.
 4. [Tokenizers](gpt4all_tokenizers.ipynb)
	 Load and implement tokenizers from local model file.
5.  [Monitor resources](test_gpt4all_vram.ipynb)
	 Monitor resources usage (VRAM GPU / RAM).